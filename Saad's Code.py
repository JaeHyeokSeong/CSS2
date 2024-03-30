import random
import string

languages = [
    (0x0030, 0x0039, 'Numbers (0-9)'),
    (0x0021, 0x002F, 'Symbols (Subset 1)'),  # Symbols ! " # $ % & ' ( ) * + , - . /
    (0x003A, 0x0040, 'Symbols (Subset 2)'),  # Symbols : ; < = > ? @
    (0x005B, 0x0060, 'Symbols (Subset 3)'),  # Symbols [ \ ] ^ _ `
    (0x007B, 0x007E, 'Symbols (Subset 4)'),  # Symbols { | } ~
    (0x0041, 0x005A, 'English (Uppercase)'),
    (0x0061, 0x007A, 'English (Lowercase)'),
    (0x3040, 0x309F, 'Japanese'),
    (0x4E00, 0x9FFF, 'Chinese'),
    (0x0410, 0x044F, 'Russian'),
    (0x0980, 0x09FF, 'Bengali'),
]

def generate_random_password(length=22):
    password_chars = []
    used_languages = set()

    for _ in range(length):
        char_range = random.choice(languages)
        char_code = random.randint(char_range[0], char_range[1])
        password_chars.append(chr(char_code))
        used_languages.add(char_range[2])

    password = ''.join(password_chars)
    return password, used_languages

password, languages_used = generate_random_password()

print(f"Generated Password: {password}")
print(f"Character Types Used: {', '.join(languages_used)}")