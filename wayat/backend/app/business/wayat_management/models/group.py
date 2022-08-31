from typing import NewType, Optional

from pydantic import BaseModel


GroupIDType = NewType("GroupIDType", str)
UsersListType = NewType("UsersListType", list[str])


class GroupID(BaseModel):
    id: GroupIDType


class GroupDTO(BaseModel):
    id: GroupIDType
    name: str
    members: UsersListType
    image_url: str


# Requests
class CreateGroupRequest(BaseModel):
    name: str
    members: UsersListType


class UpdateGroupRequest(BaseModel):
    name: Optional[str]
    members: Optional[UsersListType]


# Responses
class ListGroupsResponse(BaseModel):
    groups: list[GroupDTO]


class CreateGroupResponse(GroupID):
    pass

