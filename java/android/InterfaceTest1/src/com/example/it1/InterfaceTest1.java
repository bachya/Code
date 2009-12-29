package com.example.it1;

import android.app.Activity;     
import android.app.AlertDialog;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.Toast;

public class InterfaceTest1 extends Activity
{
  
  private Button toast_button;
  private Button notification_button;
  private Button dialog_button;
  
  /** Called when the activity is first created. */
  @Override
  public void onCreate(Bundle savedInstanceState)
  {
    super.onCreate(savedInstanceState);  
    setContentView(R.layout.buttons);

    //|
    //|  Toast button test
    //|
    this.toast_button = (Button) this.findViewById(R.id.toast_button);
    this.toast_button.setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View v)
      {
        Context context = getApplicationContext();
        CharSequence text = "I just clicked the button!";

        Toast toast = Toast.makeText(context, text, Toast.LENGTH_SHORT);
        toast.show();
      }
    });
    
    //|
    //|  Notification button test
    //|
    this.notification_button = (Button) this.findViewById(R.id.notification_button);
    this.notification_button.setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View v)
      {
        String ns = Context.NOTIFICATION_SERVICE;
        NotificationManager mNotificationManager = (NotificationManager) getSystemService(ns);
        
        int icon = R.drawable.icon;                     // icon from resources
        CharSequence tickerText = "Ticker Notice";      // ticker-text
        long when = System.currentTimeMillis();         // notification time
        Context context = getApplicationContext();      // application Context
        CharSequence contentTitle = "My Notification";  // expanded message title
        CharSequence contentText = "Hello World!";      // expanded message text

        Intent notificationIntent = new Intent(context, InterfaceTest1.class);
        PendingIntent contentIntent = PendingIntent.getActivity(context, 0, notificationIntent, 0);

        // the next two lines initialize the Notification, using the configurations above
        Notification notification = new Notification(icon, tickerText, when);
        notification.setLatestEventInfo(context, contentTitle, contentText, contentIntent);
        
        mNotificationManager.notify(1, notification);
      }
    }); 
    
    //|
    //|  Dialog button test
    //|
    this.dialog_button = (Button) this.findViewById(R.id.dialog_button);
    this.dialog_button.setOnClickListener(new OnClickListener() {
      @Override
      public void onClick(View v)
      {
        AlertDialog.Builder builder = new AlertDialog.Builder(InterfaceTest1.this);
        builder.setMessage("Are you sure you want to exit?")
               .setCancelable(false)
               .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                   public void onClick(DialogInterface dialog, int id) {
                        dialog.dismiss();
                   }
               })
               .setNegativeButton("No", new DialogInterface.OnClickListener() {
                   public void onClick(DialogInterface dialog, int id) {
                        dialog.cancel();
                   }
               });
        AlertDialog alert = builder.create();
        alert.show();
      }
    });   
  }
  
}
