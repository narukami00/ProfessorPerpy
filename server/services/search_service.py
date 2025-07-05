from config import Settings
from tavily import TavilyClient
import trafilatura
from bs4 import BeautifulSoup
import requests
from urllib.parse import urljoin, urlparse

settings = Settings()
tavily_client = TavilyClient(api_key=settings.TAVILY_API_KEY)

def is_valid_image_url(img_url, page_url):
    valid_ext = ('.jpg', '.jpeg', '.png', '.gif', '.webp')
    bad_words = ['logo', 'icon', 'sprite', 'blank', 'pixel', 'favicon',
                 'ads', 'banner', 'avatar', 'emoji', 'placeholder', 'tracker']

    if not img_url or not any(img_url.lower().endswith(ext) for ext in valid_ext):
        return False
    if img_url.startswith('data:') or img_url.strip() == '':
        return False
    if any(word in img_url.lower() for word in bad_words):
        return False
    if urlparse(img_url).netloc and (urlparse(img_url).netloc != urlparse(page_url).netloc):
        return False
    return True

def extract_good_images(url):
    images = []
    try:
        page_response = requests.get(url, timeout=5)
        soup = BeautifulSoup(page_response.text, 'html.parser')
        img_tags = soup.find_all('img')

        for img in img_tags:
            img_url = img.get('src')
            if not img_url:
                continue
            img_url = urljoin(url, img_url)
            if not is_valid_image_url(img_url, url):
                continue

            # Additional filters: skip tiny/invisible images
            width = img.get('width')
            height = img.get('height')
            if width and height:
                try:
                    if int(width) < 100 or int(height) < 100:
                        continue
                except ValueError:
                    pass

            style = img.get('style', '')
            if 'display:none' in style or 'visibility:hidden' in style:
                continue

            # Extra context filtering using alt/title
            alt = img.get('alt', '').lower()
            title = img.get('title', '').lower()
            if any(bad in alt + title for bad in ['logo', 'icon', 'ad', 'tracker', 'avatar']):
                continue

            images.append(img_url)
            if len(images) >= 3:
                break

    except Exception as e:
        print(f"[IMG ERROR] {url} -> {e}")
    return images


class SearchService:
    def web_search(self, query: str):
        try:
            results = []
            response = tavily_client.search(query, max_results=10)
            search_results = response.get("results", [])

            for result in search_results:
                url = result.get("url")
                downloaded = trafilatura.fetch_url(url)
                content = trafilatura.extract(downloaded, include_comments=False)
                images = extract_good_images(url)

                results.append({
                    "title": result.get("title", ""),
                    "url": url,
                    "content": content or "",
                    "images": images
                })


            return results
        except Exception as e:
            print(e)
