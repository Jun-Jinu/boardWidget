package com.example.board_widget

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import android.graphics.Color
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeScreenWidgetProvider : HomeWidgetProvider() {
     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context,
                        MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                val text = widgetData.getString("mainText", "기본값")
                setTextViewText(R.id.text_promise, text)

                val backgroundColor = widgetData.getString("backgroundColor", "#ffffff")
                setInt(R.id.background_color, "setBackgroundColor", Color.parseColor(color))

                
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}