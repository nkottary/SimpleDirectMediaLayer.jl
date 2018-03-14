using BinDeps
using Compat

@BinDeps.setup

libSDL2 = library_dependency("libSDL2", aliases = ["sdl2", "libsdl2-2.0", "libSDL","SDL2"])
# For now, these libraries don't work on Windows for some reason..
libSDL2_ttf = library_dependency("libSDL2_ttf", aliases = ["SDL_ttf","SDL2_ttf"], os = :Darwin)
libSDL2_mixer = library_dependency("libSDL2_mixer", aliases = ["SDL_mixer","SDL2_mixer"], os = :Darwin)

if is_apple()
    using Homebrew
    provides(Homebrew.HB, "sdl2", libSDL2, os = :Darwin)
    provides(Homebrew.HB, "SDL2_ttf", libSDL2_ttf, os = :Darwin)
    provides(Homebrew.HB, "SDL2_mixer", libSDL2_mixer, os = :Darwin)
end


if is_windows()
    provides(Binaries, URI("https://www.libsdl.org/release/SDL2-2.0.7-win32-x64.zip"), libSDL2, unpacked_dir=".")
    #provides(Binaries, URI("https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-2.0.14-win32-x64.zip"), libSDL2_ttf, unpacked_dir=".")
    #provides(Binaries, URI("https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-2.0.2-win32-x64.zip"), libSDL2_mixer, unpacked_dir=".")
end

provides(AptGet, "libsdl2-2.0", libSDL2)
provides(Yum, "SDL2", libSDL2)
provides(Pacman, "sdl2", libSDL2)

@BinDeps.install Dict(
    "libSDL2" => "libSDL2",
    "libSDL2_ttf" => "libSDL2_ttf",
    "libSDL2_mixer" => "libSDL2_mixer",
)
