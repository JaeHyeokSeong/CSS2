import random
import string

def generate_random_password():

    characters = string.ascii_letters + string.digits + string.punctuation
    
    while True:
        password = ''.join(random.choice(characters) for i in range(20))
        if (any(c.islower() for c in password) and
                any(c.isupper() for c in password) and
                any(c.isdigit() for c in password) and
                any(c in string.punctuation for c in password)):
            break

    return password

print(generate_random_password())