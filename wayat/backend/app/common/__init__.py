from typing import Callable, Any
from fastapi_keycloak import OIDCUser  # type: ignore

# Shortcut for checking current user and roles
from app.common.core.identity_provider import User
from app.common.infra import idp


def get_user(required_roles: list[str] | None = None) -> Callable[[Any], User]:
    """Returns a function that checks the current user based on an access token in the HTTP-header. Optionally verifies
    roles are possessed by the user

        Args:
            required_roles List[str]: List of role names required for this endpoint

        Returns:
            OIDCUser: Decoded JWT content

        Raises:
            ExpiredSignatureError: If the token is expired (exp > datetime.now())
            JWTError: If decoding fails or the signature is invalid
            JWTClaimsError: If any claim is invalid
            HTTPException: If any role required is not contained within the roles of the users
        """
    return idp.get_current_user(required_roles=required_roles)  # type: ignore
