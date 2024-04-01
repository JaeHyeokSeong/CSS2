#v1.7
import random
import string

def generate_random_password(total_length=32):

    if total_length < 32:
        total_length = 32
    elif total_length > 64:
        total_length = 64

    characters = string.ascii_letters + string.digits + string.punctuation

    password = ''.join(random.choice(characters) for _ in range(total_length))

    return password

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

password = generate_random_password(user_length)

print(f"Generated Password: {password}")