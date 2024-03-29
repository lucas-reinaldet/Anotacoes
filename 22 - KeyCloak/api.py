import uvicorn
from fastapi import FastAPI, Depends
from fastapi.responses import RedirectResponse
from fastapi_keycloak import FastAPIKeycloak, OIDCUser

app = FastAPI()

idp = FastAPIKeycloak(
    server_url="http://localhost:8085/auth",
    client_id="test-client",
    client_secret="IY9tiXcKC6SNFFysTfariyGtwMBUCleX",
    admin_client_secret="cbe90qZPmHyRaj4jYZJRqdNdfkdLaZZl",
    realm="Test",
    callback_uri="http://localhost:8081/callback"
)
idp.add_swagger_config(app)


@app.get("/")  # Unprotected
def root():
    return 'Hello World'


@app.get("/user")  # Requires logged in
def current_users(user: OIDCUser = Depends(idp.get_current_user())):
    return user


@app.get("/admin")  # Requires the admin role
def company_admin(user: OIDCUser = Depends(idp.get_current_user(required_roles=["admin"]))):
    return f'Hi admin {user}'


@app.get("/login")
def login_redirect():
    return RedirectResponse(idp.login_uri)


@app.get("/callback")
def callback(session_state: str, code: str):
    return idp.exchange_authorization_code(session_state=session_state, code=code)  # This will return an access token


@app.get("/rcl", tags=["reciclometro"])
def protected(user: OIDCUser = Depends(idp.get_current_user(required_roles=["reciclometro"]))):
    return "Olá usuario com a role reciclometro"

if __name__ == '__main__':
    uvicorn.run('api:app', host="127.0.0.1", port=8081)
