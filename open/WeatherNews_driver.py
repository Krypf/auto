# %% open "today and tomorrow" in Firefox
# import time
# t = time.time()
from selenium import webdriver
import os
from dotenv import load_dotenv
load_dotenv(dotenv_path="open/weather.env")
location = os.getenv("WEATHER_LOCATION")
weather_url = os.getenv(f"WEATHER_URL_{location}")

profile = webdriver.FirefoxProfile()
extensions_dirpath = os.path.expanduser(os.getenv("EXTENSIONS_PATH"))
extensions = [
    os.path.join(extensions_dirpath, os.getenv("EXTENSION_1")),
    os.path.join(extensions_dirpath, os.getenv("EXTENSION_2")),
]

driver = webdriver.Firefox(firefox_profile=profile,executable_path='/usr/local/bin/geckodriver')

for extension in extensions:
    # profile.add_extension(extension)
    driver.install_addon(extension, temporary=True)
# profile.set_preference("extensions.adblockplus.currentVersion", "2.4")

driver.get(weather_url)
driver.switch_to.window(driver.window_handles[0])
element = driver.find_elements_by_class_name("switchTab__item")
# element[1].click() # 今日明日
# element[2].click() # 週間
j = 2
element[j].click()
# print(time.time() - t,'seconds'); t = time.time()

def main():
    # Launch Firefox
    
    return 0

if __name__ == '__main__':
    main()
# %%
