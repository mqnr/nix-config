{ ... }:

let
  userKeyNile = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAeb2ds1Iq3Y2DGvMOSKbfYHsCit4O6ZBsx3gTBcD+jl";
  userKeyAcheron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKkFFkW2kjPTbVy7tHLrTZHn12cwPVOzkQmqvScdDYvM";
  userKeys = [
    userKeyNile
    userKeyAcheron
  ];

  systemKeyNile = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMzoFQASGvA5CdKAi2yTTb1I/KRtfU9ks9nQjcEGqJup";
  systemKeyAcheron = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB3+EqIeFnzk1K6EZRL2dYnQIZnzWC/brMNNvQiWVonP";
  systemKeyTigris = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAxN+2rms9h77OZB3jG7aWopkWKtBM8D8DqfdzPZQuad";
  systemKeys = [
    systemKeyNile
    systemKeyAcheron
    systemKeyTigris
  ];
in
{
}
