{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "seastar";
  version = "unstable-2024-12-15";  # Use date-based version for master

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
    systemtap-sdt
    xfsprogs
    zlib
    doxygen
    valgrind
    openssl
  ];
  
  # Fix Python script shebangs
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

# { pkgs ? import <nixpkgs> {} }:

# pkgs.stdenv.mkDerivation rec {
#   pname = "seastar";
#   version = "master";
  
#   src = pkgs.fetchFromGitHub {
#     owner = "scylladb";
#     repo = "seastar";
#     rev = "seastar-${version}";
#     hash = "sha256-d8n+razhGQZ9YV37Fp0RzKC0DHdwnohe87PgVSkymGA= ";
#   };
  
#   nativeBuildInputs = with pkgs; [
#     cmake
#     ninja
#     pkg-config
#     python3
#     python3.pkgs.pyelftools
#     python3.pkgs.pyyaml
#     ragel
#   ];
  
#   buildInputs = with pkgs; [
#     boost
#     c-ares
#     cryptopp
#     fmt
#     gnutls
#     hwloc
#     lz4
#     numactl
#     protobuf
#     lksctp-tools
#     liburing
#     libunistring
#     yaml-cpp
#     systemtap-sdt
#     xfsprogs
#     zlib
#     doxygen
#     valgrind
#     openssl
#   ];

#   postPatch = ''
#     patchShebangs scripts/
#     patchShebangs configure.py
#   '';
  
#   cmakeFlags = [
#     "-DSeastar_INSTALL=ON"
#   ];
  
#   env.NIX_CFLAGS_COMPILE = "-std=c++20";
  
#   enableParallelBuilding = true;
#   doCheck = false;
  
#   meta = with pkgs.lib; {
#     description = "High performance server-side application framework";
#     homepage = "https://seastar.io";
#     license = licenses.asl20;
#     platforms = platforms.linux;
#   };
# }
# # { pkgs ? import <nixpkgs> {} }:

# # pkgs.stdenv.mkDerivation rec {
# #   pname = "seastar";
# #   version = "25.05.0";
  
# #   src = pkgs.fetchFromGitHub {
# #     owner = "scylladb";
# #     repo = "seastar";
# #     rev = "seastar-${version}";
# #     hash = "sha256-0q4q68lmbq5kydg8i7khfw6b986c26fidysxc5yhc6g1mjnzxjbp";
# #   };
  
# #   nativeBuildInputs = with pkgs; [
# #     cmake
# #     ninja
# #     pkg-config
# #     python3
# #     python3.pkgs.pyelftools
# #     python3.pkgs.pyyaml
# #     ragel
# #   ];
  
# #   buildInputs = with pkgs; [
# #     boost
# #     c-ares
# #     cryptopp
# #     fmt
# #     gnutls
# #     hwloc
# #     lz4
# #     numactl
# #     pciutils
# #     protobuf
# #     lksctp-tools
# #     libtool
# #     liburing
# #     libxml2
# #     yaml-cpp
# #     systemtap-sdt
# #     xfsprogs
# #     libidn2
# #     libunistring
# #     trousers
# #     doxygen
# #     zlib
# #   ];
  
# #   nativeCheckInputs = with pkgs; [
# #     valgrind
# #   ];
  
# #   configurePhase = ''
# #     runHook preConfigure
    
# #     python3 ./configure.py --mode=release
    
# #     runHook postConfigure
# #   '';
  
# #   buildPhase = ''
# #     runHook preBuild
    
# #     ninja -C build/release
    
# #     runHook postBuild
# #   '';

# #    installPhase = ''
# #     runHook preInstall
  
# #     mkdir -p $out
# #     ninja -C build/release install DESTDIR=$out
  
# #     runHook postInstall
# #   ''; 
   
# #   env.NIX_CFLAGS_COMPILE = "-std=c++20";
  
# #   enableParallelBuilding = true;
  
# #   doCheck = false;
  
# #   meta = with pkgs.lib; {
# #     description = "High performance server-side application framework";
# #     homepage = "https://seastar.io";
# #     changelog = "https://github.com/scylladb/seastar/releases";
# #     license = licenses.asl20;
# #     platforms = platforms.linux;
# #     maintainers = [ ];
# #     broken = pkgs.stdenv.isDarwin;
# #   };
# # }

