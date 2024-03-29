import logging
from enum import Enum

from pydantic import ValidationError

from app.common.core.configuration import load_env_file_on_settings
from app.common.infra.gcp.firebase import FirebaseSettings, FirebaseService
from app.common.core.identity_provider import IdentityProvider
from app.common.infra.keycloak import KeycloakSettings, KeycloakService


logger = logging.getLogger(__name__)


class IDPType(Enum):
    KEYCLOAK = KeycloakService, KeycloakSettings
    FIREBASE = FirebaseService, FirebaseSettings


def __get_idp() -> tuple[None, None] | tuple[IdentityProvider, IDPType]:
    """Factory that creates the instance of the Identity Provider given the app configuration"""
    for idp_enum_value in IDPType:
        try:
            service_type, settings_type = idp_enum_value.value
            settings = load_env_file_on_settings(settings_type)  # Throws ValidationError
        except ValidationError:
            pass
        else:
            logger.info(f"Initializing IDP of type {service_type}")
            return service_type(settings), idp_enum_value
    return None, None


idp_configuration = __get_idp()

idp: IdentityProvider | None = idp_configuration[0]
idp_type: IDPType | None = idp_configuration[1]
