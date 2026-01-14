{pkgs ? import <nixpkgs> {}}:
let
  toolchain = pkgs.llvmPackages_20.stdenv;
in
toolchain.mkDerivation {
  pname = "seastar";
  version = "unstable-2026-01-13";

  src = pkgs.fetchFromGitHub {
    owner = "scylladb";
    repo = "seastar";
    rev = "HEAD";
    hash = "sha256-VU2ez4flMDtMvTVouPto9oFuGKN83E4fWkwjWZGC39c=";
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

  NIX_LDFLAGS = [
    "-lpthread"
    "-lrt"
    "-ldl"
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
