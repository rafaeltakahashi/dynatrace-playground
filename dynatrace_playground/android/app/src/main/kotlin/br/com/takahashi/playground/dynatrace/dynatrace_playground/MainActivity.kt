package br.com.takahashi.playground.dynatrace.dynatrace_playground

import android.os.Bundle
import com.dynatrace.android.agent.Dynatrace
import io.flutter.embedding.android.FlutterActivity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        CoroutineScope(Dispatchers.Main).launch {
            delay(1000)

             // This sends an action with an error.
            var action = Dynatrace.enterAction("Playground action in Android");
            action.reportEvent("Playground event in Android");
            action.reportError("Playground made up error", 50);
            action.leaveAction()
            Dynatrace.identifyUser("150");
        }
    }
}
