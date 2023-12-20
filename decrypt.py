from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization, hashes
from cryptography.hazmat.primitives.asymmetric import rsa, padding

def decrypt_message(ciphertext):
    # Load the private key
    with open('private_key.pem', 'rb') as key_file:
        private_key = serialization.load_pem_private_key(
            key_file.read(),
            password=None,
            backend=default_backend()
        )

    # Decrypt the message with the private key
    decrypted = private_key.decrypt(
        ciphertext,
        padding.OAEP(
            mgf=padding.MGF1(algorithm=hashes.SHA256()),
            algorithm=hashes.SHA256(),
            label=None
        )
    )

    # Print the decrypted message
    print("Decrypted message:", decrypted.decode('utf-8'))

if __name__ == "__main__":
    # Replace the ciphertext with the actual encrypted message from 'generate_keys_and_encrypt.py'
    ciphertext_message = b"\x17\xe9\xcd\xed\x88&>X\xebc\xca\xa9'\xdd0\x8c\x94\xf3}u\x06\xcf\x01\xbe\xf6f\xed\xd8A\xca\x96\x9e+=\x03\xbd\x04\xddr\xb7>\xa6\xaf\xe6H\xebK\t\xb6\xdb\x03\xe5\xcb\x86\xe1\x01\xd2KFN\x8b\x9e\x04Ai\xc9\x96O\r\x84\xd5\x93\xf2\xae\xba\xa6ly3\xa3z\xf0\xcc\xceT\x05\x97\x07l\xa5\xb5\xcfV\x1a\x19\xf2\xcaAN@D\xd7\xafnp\xa2\xb0\xeba8e:\xc8nn\x1f\x04\xac\xe6\x1cF\xce\xdb\x8d\xd6\xe5%\x10\x9eA\x8a\xa4\x8a&\xd7C`Q\xfd\x07-0\x0f\xa4\xf9\x9d\x159~)JI\x0b\x1c\x08\xc3{X\x91r\xa3\x94`\xc9I6\xbd\xbf\x1f\x98\xbe\x7fE\x0f\x96\x9b\\\x05I\x18;\xc8\x92\xea\x00<\x9d\xb7\x16\x07\x8f\x85\xe8\xe1;\xcc\xc9\x93,\x88\xba\xce\xb40\x02T\xf9\x17\xf0\x12\x8f7'Rf\xedx\xf9\xac\xd1bB*\xc2T\xe2\x86G\xee3v0\x12\xcblH\xc4\r3C\xd1x\xb5@\xc87\xa4h\x13\xa2\xc3v\xc6\x1c\x02\x1f"
    decrypt_message(ciphertext_message)
