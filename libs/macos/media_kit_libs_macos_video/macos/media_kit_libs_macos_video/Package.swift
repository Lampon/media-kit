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

let libmpvArtifactBase = "https://github.com/Lampon/libmpv-darwin-build/releases/download/v0.8.5-omnibox/libmpv-xcframeworks_v0.8.5-omnibox_macos-universal-video-default"
let libmpvChecksums = [
    "Ass": "62f0261c79adc9242aa3a79270822d19ed25ef3869f19fb43bad717b7d79f95e",
    "Avcodec": "a61b09bf71f136240e578cd6019bc87bd4bf2648374327a5aeb84794b3ae0853",
    "Avfilter": "c837b6b5c73f66d517dc189115f0a0cfe4019abbec95ae490e9587efe12cbba7",
    "Avformat": "271435de439710cfd1d047559826e43445781647fd86209375f7942c366c8c42",
    "Avutil": "ca6a345a63375573d3d8e9724a00e0e0e08bbb4c0494b3955e12307128b46b4f",
    "Dav1d": "56c462a48028f6a7fa84d33d5a0195bd8ed87cf3267507c17e917ed49789bb57",
    "Freetype": "2d25e00ed52cebb30501de43f018af94deeafdfc17b38eb73a52b6eb6bb56564",
    "Fribidi": "b232add870284c030d2e54fe5af7577458ecfa63554160bdbc40bea1665b1f30",
    "Harfbuzz": "673a43c1bc02b1f0ea7d29476fbdd10f678e8946fc8d42c1d718380bdf959a04",
    "Mbedcrypto": "7b87bd622868b93474d6520d3d8ef324d92968a6319bf40f59cb57ba5ab874d8",
    "Mbedtls": "de27c33786eebc05545990ba9cf5d17b53c7623bcc4ac7338e2e1bf1c43f7f2a",
    "Mbedx509": "169461c4ed7fa89d9f55e40d4af4123ebde2bfadf0bd1a6f944b924e3d9253cc",
    "Mpv": "f52abe4ebc3b3a24afffc6eaefab0aa468f0e265665f6407cdafa94015f60576",
    "Placebo": "8bbb0a591c91a14f77c6be611e88aa2f8f65de6fa0bf9d56861cdf4f747f94d5",
    "Png16": "a10c4622a2e962a1e2a971b50b6bf623c8db072a26275506a656074e75edbb73",
    "Swresample": "abd3a4e4a9e4464dbca040efcbd5559d762f9b9e910338900b257ff71a58d554",
    "Swscale": "585a82f75a35cbf0ee4d97b52fe216538e650a39170bfbe9d0559eea5dbb66cf",
    "Uchardet": "13f7a424233c9abbad53fa13c264a75c07a9f3a3751626ad23997ca587f5f60e",
    "Xml2": "498ec8569ba185fff7331eb6e556f75c64724cc56e8f640508fc4776a97b6bd0"
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
