{pkgs ? import <nixpkgs> {}}:
let
  toolchain = pkgs.llvmPackages_latest.stdenv;
in
toolchain.mkDerivation {
  pname = "seastar";
  version = "unstable-2026-1-13";

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
    p11-kit
    toolchain.cc.libc
  ];

  postPatch = ''
    patchShebangs scripts/
    patchShebangs configure.py
  '';

  cmakeFlags = [
    "-DSeastar_INSTALL=ON"
  ];

  env.NIX_CFLAGS_COMPILE = "-std=c++23";

  enableParallelBuilding = true;
  doCheck = false;

  meta = with pkgs.lib; {
    description = "High performance server-side application framework";
    homepage = "https://seastar.io";
    license = licenses.asl20;
    platforms = platforms.linux;
  };
}
