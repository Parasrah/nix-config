{ username, home, user }:

{
  users.users."${username}" = home;
  homemanager.users."${username}" = user;
}
