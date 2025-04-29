# %% open Twitter
import os
# from selenium.webdriver.common.by import By
# import sys
from dotenv import load_dotenv
from open_firefox import open_firefox

import time

t = time.time()
load_dotenv(dotenv_path="open/Twitter.env")
twitter_url = os.getenv("TWITTER_URL")

driver = open_firefox()
driver.get(twitter_url)
driver.switch_to.window(driver.window_handles[0])

print(time.time() - t,'seconds'); t = time.time()
# %%
