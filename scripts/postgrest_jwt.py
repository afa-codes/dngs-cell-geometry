"""Sign a JWT for PostgREST (HS256), e.g. the coordination's token.

  python scripts/postgrest_jwt.py --secret-file ~/delphi-jwt-secret --days 30
  export DELPHI_JWT=$(python scripts/postgrest_jwt.py --secret-file ~/delphi-jwt-secret)

The secret is the jwt-secret of the PostgREST configuration (at least 32
characters). Keep both the secret and the tokens outside the repository.
"""
import argparse
import base64
import hashlib
import hmac
import json
import time


def b64(data):
    return base64.urlsafe_b64encode(data).rstrip(b"=").decode()


def sign(secret, claims):
    header = b64(json.dumps({"alg": "HS256", "typ": "JWT"}, separators=(",", ":")).encode())
    payload = b64(json.dumps(claims, separators=(",", ":")).encode())
    mac = hmac.new(secret.encode(), f"{header}.{payload}".encode(), hashlib.sha256).digest()
    return f"{header}.{payload}.{b64(mac)}"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--secret-file", required=True)
    ap.add_argument("--role", default="delphi_coord")
    ap.add_argument("--days", type=float, default=7, help="validity in days")
    args = ap.parse_args()
    secret = open(args.secret_file, encoding="utf-8").read().strip()
    if len(secret) < 32:
        raise SystemExit("the secret must have at least 32 characters")
    print(sign(secret, {"role": args.role, "exp": int(time.time() + args.days * 86400)}))


if __name__ == "__main__":
    main()
