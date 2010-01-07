package com.android.example.timebutton;

import java.util.Date;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class TimeButton extends Activity implements View.OnClickListener {
    
	Button btn;
	
	/** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        btn = (Button)findViewById(R.id.button);
        btn.setOnClickListener(this);
        updateTime();
    }

	private void updateTime() {
		btn.setText(new Date().toString());
	}

	@Override
	public void onClick(View arg0) {
		updateTime();
	}
}