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

let libmpvArtifactBase = "https://github.com/Lampon/libmpv-darwin-build/releases/download/v0.8.6-omnibox/libmpv-xcframeworks_v0.8.6-omnibox_ios-universal-video-default"
let libmpvChecksums = [
    "Ass": "383e9c472dce7e9c590478035ad7ce223b28ccb72cce0bc026e07163fbd273c4",
    "Avcodec": "1699d07877aa367d97adb038145b4adf6c819f72d985e139033b2427c0cfffcf",
    "Avfilter": "ee0bf43d6fbf7ebf091391da416a12df09614904ff14ea9280c4c3d10a538966",
    "Avformat": "6c3ae95785648cfaab7407c02af8ee09d5609fc1e8968ce3bd4b7622b4700bf2",
    "Avutil": "c411b4b51dca2038fb1c3e3b7bee8f5ef4315c29a0657a2a52d9da7313d6cb12",
    "Dav1d": "88cc5db5d4433135b0c56f3363ddefa20d8dd6ac29d0713cb5152d84a32c4e39",
    "Freetype": "367aa041d9be40853beea1eec044216d46f36bf24e16a9877270b512cb1ee315",
    "Fribidi": "b03c99102a182d30aec2fc80f532b83f7e0a5c3db65ddf375401c5b461677302",
    "Harfbuzz": "7784985281b95574c979557fce03d92ba6b846aa930eeea6fc32cb8926b2367d",
    "Mbedcrypto": "cdd848751ba21ed04dd80fd8ca49f5f13c9b69bc82ea7a86d4e5576e897df632",
    "Mbedtls": "b87e4c688fc3de4ed2c3f8a705e65ca52347c01b42c5c9d03cc6e2f80a7c1a94",
    "Mbedx509": "3fe791f313720ae986bf816f52a706ad8f48342cecacb0c3cf3ffa7d1bcaf270",
    "Mpv": "8099c6a2ffeb5739d0aee9b62659a71fd7b7ce5d530027fa9216f877fb985d3e",
    "Placebo": "8c382331f81bf8eec02756cd06d6ec0d2f66635630801f30942148e996fb212a",
    "Png16": "4d1e2ef1c059a990ae73f364005ce47fe213849bd33e954a9283fd04b4a629a9",
    "Swresample": "660bf5e8951f88845f257cd920dd5864a7adf85f9ffdab71c14ac4ce01167771",
    "Swscale": "a85575280658b308f82f94d942799f65b7cd614bbe98180720d721d3a2ad0744",
    "Uchardet": "3a9bf99763fbfc71b3804c31453535946ef40c9adf4c7e73590804c683607cae",
    "Xml2": "8e860c67b4c7bf995d6e35a0fd27663bd02572bf5830176048b5331cd3bd15f9"
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
