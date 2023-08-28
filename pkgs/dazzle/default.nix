{ buildGoModule, lib, fetchFromGitHub, testers }:

buildGoModule rec {
  pname = "dazzle";
  version = "0.1.17";

  src = fetchFromGitHub {
    owner = "gitpod-io";
    repo = "dazzle";
    rev = "v${version}";
    sha256 = "sha256-WGz4WjPdzQ78hjOSxzMg0kGX+ABSVo6NtvK7nTKOIjM=";
  };

  # If upstream updates Go module vendoring, use the provided hash from
  # the error code.
  vendorSha256 = "sha256-hHaybdSHdzKXd3vAdZ7b3JGVHK4RZVd02guzmoHSPsE=";

  buildHook = ''
    runHook preBuild
    mkdir bin
    go generate -v ./...
    go build -v -o bin/dazzle -s -w -X github.com/gitpod-io/dazzle/cmd/core.version=-${version} main.go
    go build -v -o bin/dazzle-util -s -w -X github.com/gitpod-io/dazzle/cmd/util.version=${version} main-util.go
    runHook postBuild
    ls bin
  '';

  installPhase = ''
    runHook preInstall
    mkdir $out/bin
    install -Dm755 bin/dazzle bin/dazzle-util -t $out/bin
    runHook postInstall
  '';

  meta = with lib; {
    description = "dazzle is a rather experimental Docker image builder which builds independent layers";
    homepage = "https://github.com/gitpod-io/dazzle";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ ajhalili2006 ];
    broken = true; # still ironing out build
  };
}
