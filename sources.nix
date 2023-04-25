{ fetchFromGitHub
, runCommand
, nix
, xz
}:
let
  mkNar = { pname, version, src }:
    runCommand "${pname}-${version}-source"
    {
      nativeBuildInputs = [ nix xz ];
    }
    ''
      mkdir $out
      nix-store --dump ${src} | xz -c > "$out/${pname}-${version}-source.nar.xz"
    '';
in
{
  stage0-posix = mkNar {
    pname = "stage0-posix";
    version = "unstable-2023-04-24";
    src = fetchFromGitHub {
      owner = "oriansj";
      repo = "stage0-posix";
      rev = "bdd3ee779adb9f4a299059d09e68dfedecfd4226";
      sha256 = "hMLo32yqXiTXPyW1jpR5zprYzZW8lFQy6KMrkNQZ89I=";
      fetchSubmodules = true;
    };
  };
}
