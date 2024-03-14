import pyautogui
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

@keyword('Press Button')
def send_keys(str):
    pyautogui.press(str)


@keyword('Close Application Pop-up')
def press_escape_key():
    pyautogui.press('escape')


@keyword('Get List Length')


def get_list_length(list):
    count = 0
    for element in list:
        count += 1
    return count


@keyword('Check If URL Contains')
def Chk_URL(URLS,URL,button_name):
    count=1
    for  url in URLS:
        if url==URL:
            BuiltIn().log_to_console("{}'s {} Link/Button Text Matched".format(button_name,count))  
            return True
        count=count+1    
    return False