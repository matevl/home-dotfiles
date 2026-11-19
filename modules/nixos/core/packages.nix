{ pkgs, ... }:
{
  # System packages
  environment.systemPackages = with pkgs; [
    git
    gcc
    man-pages
    man-pages-posix
    tree
    wget
    curl
  ];
}
