#v1.5
import random
import string

languages = [
    (0x0030, 0x0039, 'Numbers (0-9)'),
    (0x0021, 0x002F, 'Symbols (Subset 1)'),  # Symbols ! " # $ % & ' ( ) * + , - . /
    (0x003A, 0x0040, 'Symbols (Subset 2)'),  # Symbols : ; < = > ? @
    (0x005B, 0x0060, 'Symbols (Subset 3)'),  # Symbols [ \ ] ^ _ `
    (0x007B, 0x007E, 'Symbols (Subset 4)'),  # Symbols { | } ~
    (0x0041, 0x005A, 'English (Uppercase)'),  # Basic Latin uppercase A-Z
    (0x0061, 0x007A, 'English (Lowercase)'),  # Basic Latin lowercase a-z
    (0x3040, 0x309F, 'Japanese'),
    (0x4E00, 0x9FFF, 'Chinese'),
    (0x0410, 0x044F, 'Russian'),
    (0x0980, 0x09FF, 'Bengali'),
    (0xAC00, 0xD7AF, 'Korean'),
]

def generate_random_password(total_length=32):

    if total_length < 32:
        total_length = 32
    elif total_length > 64:
        total_length = 64

    chars_to_generate = total_length - 4

    password_chars = []
    used_languages = set()

    for _ in range(chars_to_generate):
        char_range = random.choice(languages)
        char_code = random.randint(char_range[0], char_range[1])
        password_chars.append(chr(char_code))
        used_languages.add(char_range[2])

    half_index = len(password_chars) // 2
    first_half = ''.join(password_chars[:half_index])
    second_half = ''.join(password_chars[half_index:])

    password = f"({first_half})-({second_half})"

    return password, used_languages

def get_valid_password_length():
    while True:
        try:
            user_length = int(input("Enter the desired total password length (32-64): "))
            if 32 <= user_length <= 64:
                return user_length
            else:
                print("Please enter a number between 32 and 64.")
        except ValueError:
            print("Please enter a valid integer.")

user_length = get_valid_password_length()

password, languages_used = generate_random_password(user_length)

print(f"Generated Password: {password}")
print(f"Character Types Used: {', '.join(languages_used)}")