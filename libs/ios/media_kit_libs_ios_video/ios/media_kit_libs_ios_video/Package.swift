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

let libmpvArtifactBase = "https://github.com/Lampon/libmpv-darwin-build/releases/download/v0.8.5-omnibox/libmpv-xcframeworks_v0.8.5-omnibox_ios-universal-video-default"
let libmpvChecksums = [
    "Ass": "a9400770371e23ac9b69b218875d33e10598c5e4c487341c14bee496cf465e62",
    "Avcodec": "14a7bf26870a9c1a30a1dc1d812ee88da1d5cb2478e7dfcef64296641b38ce33",
    "Avfilter": "a84b1ccc0270e85eb3f130f7c04a47a3738d8f2a0689b7646e107661cd7dba0f",
    "Avformat": "96149b45b0724b8f8f8b57ccc1afb9f6c1282870e28d2f5b2ce4957887d34b79",
    "Avutil": "afd3b633dd7314afa06338323d487cd2fd2a424ec49e75fa890883f8106aaf2a",
    "Dav1d": "1b6f2ab0fb14ec669033cc83fc4220e9f3303f4d35928c3c03dc5f8e6a296739",
    "Freetype": "ddd2f79c33d3587e0181a0ac189ae8f8e6aa3a55ce18077439b32b50212eda22",
    "Fribidi": "0ab948c42531690eb6360e8857689e245dbfa77f232caafa16f95340509405ca",
    "Harfbuzz": "2764c015d37759eec3652712332908fbdba667fb1f2aac76b7a6e5aa83c37b00",
    "Mbedcrypto": "7a7e743d9df5ad8436c1ea0a8756aa65033fc79898bd9713368f9ef18a42436c",
    "Mbedtls": "e1de5c658ca21c4ea221b4614d26ba8c74a45920f66141b95ae10d0b22928c64",
    "Mbedx509": "1a7b6debf5ee57bf56bf1e8902ae8c1d0b24196ec4d4949c64c9d64bd0c3d3d3",
    "Mpv": "465bc41bd919de30338cc8f76c9dbf6916936eac95f8766e29b9ce29d504c4c1",
    "Placebo": "00847388c9d701c53dd1355acabc6d1793f31af492d01ee24e35974d82ac1698",
    "Png16": "23ba74aa7f3d04a22031153d67a352e8f129685399a32f10e35a1c21e48b4ba6",
    "Swresample": "d725f4cd4b9b996d5e30b030a715b9f7a6b193616b71041816138863e3444d9d",
    "Swscale": "ec0d520c139fae723702def40e185040094b96b2731e746c2d325adffc3263b2",
    "Uchardet": "cca0fc3cb4b837bf5734be2d37ccb1f8deb9d5d0782b43585361ac9b93a21bca",
    "Xml2": "9726e2a8a30682062c8c15e5735543fb64f24abdf07ec53d6cb7b0bdc5a5545c"
]
let libmpvProductTargets: [String] = ["media_kit_libs_ios_video"] + libmpvTargets

let package = Package(
    name: "media_kit_libs_ios_video",
    platforms: [
        .iOS("9.0")
    ],
    products: [
        .library(name: "media-kit-libs-ios-video", targets: libmpvProductTargets),
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
            name: "media_kit_libs_ios_video",
            dependencies: libmpvTargets.map { framework in .target(name: framework) },
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
