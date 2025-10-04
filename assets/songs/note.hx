var weekNotes:Bool = false;

function onNoteCreation(event) {
    if (curSong == "gemaplay") {
        weekNotes = true;
        event.noteSprite = 'game/notes/notes_gema';
    }
}

function onStrumCreation(event) {
    if (curSong == "gemaplay") {
        weekNotes = true;
        event.sprite = 'game/notes/notes_gema';
    }
}

function postCreate() {
    for (i in 0...4) {
        if (weekNotes) {
            playerStrums.members[i].x += 40 + (i*10);
            cpuStrums.members[i].x += -40 + (i*10);
        } else {
            playerStrums.members[i].x += 40 + (i*5);
            cpuStrums.members[i].x += -40 + (i*5);
        }
    }
}

if (curSong == "ghosttap") disableScript();
