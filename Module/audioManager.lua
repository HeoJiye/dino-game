
local audioData = {
    bgm = audio.loadStream("Content/Audio/bgm.mp3"),
    sounds = {
        audio.loadSound("Content/Audio/01_button.mp3"),
        audio.loadSound("Content/Audio/02_defeat.mp3"),
        audio.loadSound("Content/Audio/03_silde.mp3"),
        audio.loadSound("Content/Audio/04_jump.mp3"),
    },
    bgmChannel = 1,
    soundChannel = 2
}

local audioManager = { }

function audioManager:bgmOn()
    audio.play(audioData.bgm, { loops = -1 })
end
function audioManager:soundOn( idx )
    audio.play(audioData.sounds[idx])
end

function audioManager:pause()
    audio.pause(0)
end
function audioManager:resume()
    audio.resume()
end
function audioManager:stop()
    audio.stop()
end

return audioManager