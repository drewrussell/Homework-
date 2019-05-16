#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
from bs4 import BeautifulSoup as bs 
import requests
from splinter import Browser


# In[2]:


#NASA Mars News
url="https://mars.nasa.gov/news/?page=0&per_page=40&order=publish_date+desc%2Ccreated_at+desc&search=&category=19%2C165%2C184%2C204&blank_scope=Latest"


# In[3]:


response = requests.get(url)


# In[4]:


soup = bs(response.text, 'html.parser')


# In[5]:


print(soup.prettify())


# In[6]:


results = soup.find_all('div', class_="content_title")


# In[7]:


news_title=results[0].text.strip()
print(news_title)


# In[8]:


results2 = soup.find_all('div', class_="rollover_description_inner")
news_p=results2[0].text.strip()
print(news_p)


# In[9]:


#JPL Mars Space Images - Featured Image
get_ipython().system('which chromedriver')


# In[10]:


executable_path = {'executable_path': '/usr/local/bin/chromedriver'}
browser = Browser('chrome', **executable_path, headless=False)


# In[11]:


url = 'https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars'
browser.visit(url)


# In[12]:


for x in range(50):
    # HTML object
    html = browser.html
    # Parse HTML with Beautiful Soup
    soup = bs(html, 'html.parser')
    # Retrieve all elements that contain book information
    articles = soup.find_all('article', class_='carousel_item')
   
    
    for article in articles:
        footer = article.find('footer')
        link = footer.find('a')
        href= link['data-fancybox-href']
        
image=href
featured_image_url=('https://www.jpl.nasa.gov' + image)
print(featured_image_url)


# In[18]:


#Mars Weather 
url2="https://twitter.com/marswxreport?lang=en"
response = requests.get(url2)
soup = bs(response.text, 'html.parser')
mars_soup = soup.find_all('p', class_='TweetTextSize TweetTextSize--normal js-tweet-text tweet-text')
mars_weather=mars_soup[1].text.strip()
mars_weather


# In[24]:


#Mars Facts
url3 = 'https://space-facts.com/mars/'
tables = pd.read_html(url3)
tables


# In[34]:


df = tables[0]
df.columns
df.head()


# In[28]:


html_table = df.to_html()
html_table


# In[29]:


html_table.replace('\n', '')


# In[35]:


df.to_html('table.html')
get_ipython().system('open table.html ')


# In[ ]:


#Mars Hemispheres

def init_browser():
    # @NOTE: Replace the path with your actual path to the chromedriver
    executable_path = {"executable_path": "/usr/local/bin/chromedriver"}
    return Browser("chrome", **executable_path, headless=False)


def scrape():
    browser = init_browser()
    listings = {}

    url = ""
    browser.visit(url)

    html = browser.html
    soup = BeautifulSoup(html, "html.parser")

    listings[""] = soup.find("a", class_="").get_text()
    listings[""] = soup.find("span", class_="").get_text()
    listings[""] = soup.find("span", class_="").get_text()

    return listings

