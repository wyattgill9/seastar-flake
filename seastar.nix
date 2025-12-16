{pkgs ? import <nixpkgs> {}}:
pkgs.stdenv.mkDerivation {
  pname = "seastar";
  version = "unstable-2024-12-15";

  src = pkgs.fetchFromGitHub {
    owner = "scylladb";
    repo = "seastar";
    rev = "a74d64f625c19a76f5ec0ad8cac96eb00a667136";
    hash = "sha256-DvupGfA1JuwV3gX04VVOyxiq+yUAD5t+4yMrauIEREo=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    ninja
    pkg-config
    python3
    python3.pkgs.pyelftools
    python3.pkgs.pyyaml
    ragel
  ];

  buildInputs = with pkgs; [
    boost
    c-ares
    cryptopp
    fmt
    gnutls
    hwloc
    lz4
    numactl
    protobuf
    lksctp-tools
    liburing
    libunistring
    yaml-cpp
    libsystemtap
    xfsprogs
    zlib
    doxygen
    valgrind
    openssl
  ];

  propagatedBuildInputs = with pkgs; [
    boost
    c-ares
    cryptopp
    fmt
    gnutls
    hwloc
    lz4
    numactl
    protobuf
    lksctp-tools
    liburing
    libunistring
    yaml-cpp
    systemtap-sdt
    xfsprogs
    zlib
    openssl
    libtasn1
    libidn2
  ];

  postPatch = ''
    patchShebangs scripts/
    patchShebangs configure.py
  '';

  cmakeFlags = [
    "-DSeastar_INSTALL=ON"
  ];

  env.NIX_CFLAGS_COMPILE = "-std=c++20";

  enableParallelBuilding = true;
  doCheck = false;

  meta = with pkgs.lib; {
    description = "High performance server-side application framework";
    homepage = "https://seastar.io";
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
