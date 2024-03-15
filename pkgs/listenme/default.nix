{ lib
, buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
  pname = "listenme";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "msqtt";
    repo = "listenme";
    rev = "v${version}";
    hash = "sha256-WXkCFOArk1RENoF7P4K1IxzFPKJeexRSg90JQKT4VVI=";
  };

  vendorHash = "sha256-R9m0sj4ReajbU/+Iro7xYkCVNcGZ+VT0/GFeOd/R8pA=";

  meta = with lib; {
    description = "一个可以把本地 pulseaudio 声音广播到 web 的工具。";
    homepage = "https://github.com/msqtt/listenme";
    license = licenses.free;
    maintainers = with maintainers; [ msqtt ];
  };
}
