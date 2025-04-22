# %% open "today and tomorrow" in Firefox
import time

from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from selenium.webdriver.common.by import By
import os
import sys
from dotenv import load_dotenv



def switch_weather_tab(driver, mode: str):
    """
    天気表示モードを切り替える（待機なし）。

    mode: "min", "hour", "day", "week"
    """
    mode_to_id = {
        "min": "wxtab1",
        "hour": "wxtab2",
        "day": "wxtab3",
        "week": "wxtab4"
    }

    if mode not in mode_to_id:
        raise ValueError(f"Invalid mode: {mode}. Choose from 'min', 'hour', 'day', 'week'.")

    tab_id = mode_to_id[mode]
    driver.find_element(By.ID, tab_id).click()

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
    options = webdriver.FirefoxOptions()
    service = Service(executable_path='/usr/local/bin/geckodriver')
    driver = webdriver.Firefox(options=options, service=service)
    # confer
    # https://www.selenium.dev/ja/documentation/webdriver/browsers/firefox/
    
    for extension in extensions:
        driver.install_addon(extension, temporary=True)

    driver.get(weather_url)
    driver.switch_to.window(driver.window_handles[0])

    tab = sys.argv[1] if len(sys.argv) > 1 else "hour"
    switch_weather_tab(driver, tab)

    return 0

if __name__ == '__main__':
    # t = time.time()
    main()
    # print(time.time() - t,'seconds'); t = time.time()
    
# %%
