# %% open "today and tomorrow" in Firefox
from selenium import webdriver
import os
from dotenv import load_dotenv

def main():
    load_dotenv(dotenv_path="open/weather.env")
    location = os.getenv("WEATHER_LOCATION")
    weather_url = os.getenv(f"WEATHER_URL_{location}")

    extensions_dirpath = os.path.expanduser(os.getenv("EXTENSIONS_PATH"))
    extensions = [
        os.path.join(extensions_dirpath, os.getenv("EXTENSION_1")),
        os.path.join(extensions_dirpath, os.getenv("EXTENSION_2")),
    ]

    # Launch Firefox
    profile = webdriver.FirefoxProfile()
    driver = webdriver.Firefox(firefox_profile=profile,executable_path='/usr/local/bin/geckodriver')

    for extension in extensions:
        driver.install_addon(extension, temporary=True)

    driver.get(weather_url)
    driver.switch_to.window(driver.window_handles[0])
    element = driver.find_elements_by_class_name("switchTab__item")
    j = 1 # 今日明日
    j = 2 # 週間
    element[j].click()
    return 0

if __name__ == '__main__':
    # import time
    # t = time.time()
    main()
    # print(time.time() - t,'seconds'); t = time.time()
    
# %%
