import os
from selenium import webdriver
from selenium.webdriver.firefox.service import Service
from dotenv import load_dotenv

def open_firefox():
    load_dotenv(dotenv_path="config/firefox.env")
    
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
    
    return driver

if __name__ == '__main__':
    open_firefox()
