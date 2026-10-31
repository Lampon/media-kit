// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let libmpvTargets = [
    "Ass",
    "Avcodec",
    "Avfilter",
    "Avformat",
    "Avutil",
    "Dav1d",
    "Freetype",
    "Fribidi",
    "Harfbuzz",
    "Mbedcrypto",
    "Mbedtls",
    "Mbedx509",
    "Mpv",
    "Placebo",
    "Png16",
    "Swresample",
    "Swscale",
    "Uchardet",
    "Xml2"
]

let libmpvArtifactBase = "https://github.com/Lampon/libmpv-darwin-build/releases/download/v0.8.6-omnibox/libmpv-xcframeworks_v0.8.6-omnibox_macos-universal-video-default"
let libmpvChecksums = [
    "Ass": "8955bd686a631c11080ea586f0828d804a420e9fe383c824e72b0991b00f20aa",
    "Avcodec": "f7f1169ad3180e97d3b2b03adbc0ac5a7c63eb942012a0dca3f9f6ae29de2468",
    "Avfilter": "783433f2fa4924ffd6f161465e2a9fa823323ed241586c7966a12bc24a98147f",
    "Avformat": "8d1699e7477b2445c7808f6f654f8fbd31c99d5616aa0467d19fd5e86813f183",
    "Avutil": "293ffaf882e5cdc8696b5529dacc14918a88c4d0aca2d9cafa7b792561c5674b",
    "Dav1d": "9e3f816c6e3e49faa9f5927789986084d76aeb495f6bfddba212ba9511480092",
    "Freetype": "f9f30975a5e1884ae120fc5f643b7f5967c207edff1f859e67f2bd5afbe87d6d",
    "Fribidi": "715ab73aa514bbfc059be58ae1cdb9fa6be41520111ce3f8f0588bcc4143285c",
    "Harfbuzz": "35b70d6ba505601ef47797fe2cfdaf82f239810000bca575570fd3a35ce83509",
    "Mbedcrypto": "3c1b76a3816c928f9afd69d70f90fd56b15def854e9b0204866270a4b5cf783c",
    "Mbedtls": "3ca33cd79ac4c185ff76f4f2c2ad3ab00357e2c008919cff5abe51c2019be050",
    "Mbedx509": "f43462db0f7360364b5ca21cbe1857c414fa8e71e82b88c413700e8166226666",
    "Mpv": "47535a5c5b8e33b537199582abcbf2b8e6235146fce3656bca9aad80eacaaed7",
    "Placebo": "a8083d8294004ccb362ab942dad6ccb83d4517c5a04275132dc4b16f16dd3121",
    "Png16": "70ee804fadd382dbdb5d15d093d7a6320f68f0cdf5c42170b12e2f5c47098a9b",
    "Swresample": "fac34e19adaff13afeb38aeea4ddede9072e55280047f64d187daad815da37f2",
    "Swscale": "50b57b80c0ec93ed4e032a22c1c23c500ae3ec5f51496acf4d7367619200bc6c",
    "Uchardet": "d7a7e79ec9d8c566b452f312d2745044e7f19afc22f0e56b581734ba797081a9",
    "Xml2": "58961b6afad8a3a4b7e7133bcf66396d5a2174501f3df8a1a4a3cf038d739c59"
]
let libmpvProductTargets: [String] = ["media_kit_libs_macos_video"] + libmpvTargets

let package = Package(
    name: "media_kit_libs_macos_video",
    platforms: [
        .macOS("10.9")
    ],
    products: [
        .library(name: "media-kit-libs-macos-video", targets: libmpvProductTargets),
        .library(name: "Mpv", targets: ["Mpv"])
    ],
    dependencies: [],
    targets: libmpvTargets.map { framework in
        .binaryTarget(
            name: framework,
            url: "\(libmpvArtifactBase)_\(framework).zip",
            checksum: libmpvChecksums[framework]!
        )
    } + [
        .target(
            name: "media_kit_libs_macos_video",
            dependencies: libmpvTargets.map { framework in .target(name: framework) },
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
