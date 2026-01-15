{pkgs ? import <nixpkgs> {}}:
let
  toolchain = pkgs.llvmPackages_20.stdenv;
in
toolchain.mkDerivation {
  pname = "seastar";
  version = "25.05.0";

  src = pkgs.fetchFromGitHub {
    owner = "scylladb";
    repo = "seastar";
    rev = "a032d53884da67e4c89715d90ec222a9d7d90db6";
    hash = "sha256-m7BPvy7htYNp7Wn+u4YnwA33yDN/e5JeliwTDbLRN8U=";
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
    libaio
    libxfs
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
    libsystemtap
    xfsprogs
    zlib
    openssl
    libtasn1
    libidn2
    p11-kit
  ];

  postPatch = ''
    patchShebangs scripts/
    patchShebangs configure.py
  '';

  cmakeFlags = [
    "-DSeastar_INSTALL=ON"
    "-DSeastar_DPDK=OFF"
    "-DSeastar_CXX_FLAGS=-std=c++23"
  ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-std=c++23"
    "-Wno-error"
  ];

  enableParallelBuilding = true;
  doCheck = false;

  meta = with pkgs.lib; {
    description = "High performance server-side application framework";
    homepage = "https://seastar.io";
    license = licenses.asl20;
    platforms = platforms.linux;
    maintainers = [];
  };
}
