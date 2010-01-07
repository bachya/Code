package com.android.example.radiolayout;

import android.app.Activity;
import android.os.Bundle;
import android.view.Gravity;
import android.widget.LinearLayout;
import android.widget.RadioGroup;

public class RadioLayout extends Activity 
implements RadioGroup.OnCheckedChangeListener {
    
	RadioGroup orientation;
	RadioGroup gravity;
	
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        orientation = (RadioGroup)findViewById(R.id.orientation);
        orientation.setOnCheckedChangeListener(this);
        gravity = (RadioGroup)findViewById(R.id.gravity);
        gravity.setOnCheckedChangeListener(this);
    }

	@Override
	public void onCheckedChanged(RadioGroup group, int buttonId) {
		if ( group == orientation ) {
			if ( buttonId == R.id.horizontal )
				orientation.setOrientation(LinearLayout.HORIZONTAL);
			else
				orientation.setOrientation(LinearLayout.VERTICAL);
		}
		else if ( group == gravity ) {
			if ( buttonId == R.id.left )
				gravity.setGravity(Gravity.LEFT);
			else if ( buttonId == R.id.center )
				gravity.setGravity(Gravity.CENTER_HORIZONTAL);
			else if ( buttonId == R.id.right )
				gravity.setGravity(Gravity.RIGHT);
		}
	}
}