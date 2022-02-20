package options;

class ForcedSettings extends MusicBeatState
{
    override function create() {
        super.create();
    }

    override function update(elapsed:Float)
        {
            super.update(elapsed);
        }
    
    public static function applyForcedSettings()
        {
            Reflect.setProperty(ClientPrefs, 'framerate', 240);
            /*ClientPrefs.comboOffset[0] = 47;
            ClientPrefs.comboOffset[1] = 22;
            ClientPrefs.comboOffset[2] = 187;
            ClientPrefs.comboOffset[3] = 90;*/
            //ClientPrefs.comboOffset[4] = -79;
            //ClientPrefs.comboOffset[5] = -58; // incase we want to offset the combo or smt
        }
}