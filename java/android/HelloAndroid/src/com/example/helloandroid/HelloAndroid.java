package com.example.helloandroid;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.Toast;

public class HelloAndroid extends Activity {
  
    private Button my_button;
  
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.setContentView(R.layout.main);
        this.my_button = (Button)this.findViewById(R.id.my_button);
        this.my_button.setOnClickListener(new OnClickListener() {
          @Override
          public void onClick(View v) {
            Context context = getApplicationContext();
            CharSequence text = "I just clicked the button!";
            
            Toast toast = Toast.makeText(context, text, Toast.LENGTH_SHORT);
            toast.show();
          }
        });
    }
    
}