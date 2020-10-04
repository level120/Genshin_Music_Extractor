REM This context have a no any question and closing.
REM Based on https://github.com/Vextil/Wwise-Unpacker

@echo off

FOR %%n IN ("PCK_Repo\*.PCK") DO (
    MOVE "%%n" "Wwise-Unpacker\Game Files"

    FOR %%a IN ("Wwise-Unpacker\Game Files\*.PCK") DO ("Wwise-Unpacker\Tools\quickbms.exe" "Wwise-Unpacker\Tools\wavescan.bms" "Wwise-Unpacker\Game Files" "Wwise-Unpacker\Tools\Decoding")
    FOR %%b IN ("Wwise-Unpacker\Game Files\*.BNK") DO ("Wwise-Unpacker\Tools\bnkextr.exe" "%%b" & MOVE *.wav "Wwise-Unpacker\Tools\Decoding")
    FOR %%c IN ("Wwise-Unpacker\Tools\Decoding\*.WAV") DO ("Wwise-Unpacker\Tools\ww2ogg.exe" "%%c" --pcb "Wwise-Unpacker\Tools\packed_codebooks_aoTuV_603.bin" & DEL "%%c")
    FOR %%d IN ("Wwise-Unpacker\Tools\Decoding\*.OGG") DO ("Wwise-Unpacker\Tools\revorb.exe" "%%d" & MOVE "%%d" "Wwise-Unpacker\MP3")
    FOR %%e IN ("Wwise-Unpacker\MP3\*.OGG") DO ("Wwise-Unpacker\Tools\ffmpeg.exe" -i "%%e" -acodec libmp3lame -q:a 0 -y "Wwise-Unpacker\MP3\%%~ne.mp3" & DEL "%%e")

    echo -------------------------------------------------------------
    echo %%n - Unpack finished!
    echo -------------------------------------------------------------
    echo.

    FOR %%e IN ("Wwise-Unpacker\Game Files\*.PCK") DO (DEL "%%e")
    FOR %%f IN ("Wwise-Unpacker\Game Files\*.BNK") DO (DEL "%%f")

    echo %%n - Dummy files deleted

    FOR %%b IN ("Wwise-Unpacker\MP3\*.mp3") DO (MOVE "%%b" "Music")

    echo %%n - Extract files Copied
)

pause
exit