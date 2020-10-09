import com.splendo.kaluga.alerts.AlertInterface
import com.splendo.kaluga.alerts.buildAlert
import com.splendo.kaluga.architecture.observable.Observable
import com.splendo.kaluga.architecture.observable.subjectOf
import com.splendo.kaluga.architecture.viewmodel.BaseViewModel
import com.splendo.kaluga.hud.HUD
import com.splendo.kaluga.hud.HUDStyle
import com.splendo.kaluga.hud.HudConfig
import com.splendo.kaluga.hud.presentDuring
import com.splendo.kaluga.resources.localized
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class TestViewModel(
    val alertBuilder: AlertInterface.Builder,
    val hudBuilder: HUD.Builder
) : BaseViewModel() {
    val nameFieldText = subjectOf("", coroutineScope)
    private val _nameLabelText = subjectOf("Default value", coroutineScope)
    val nameLabelText: Observable<String> = _nameLabelText

    fun printToLabel() {
        _nameLabelText.post(nameFieldText.current)
    }

    fun showAlert() {
        coroutineScope.launch {
            alertBuilder.buildAlert {
                setTitle("Alert!!")
                setMessage("Some Alert Message")
                setPositiveButton("OK") {
                    coroutineScope.launch {
                        hudBuilder.create(HudConfig(HUDStyle.SYSTEM, "Loading")).presentDuring {
                            delay(1000)
                        }
                    }
                }
            }.show()
        }
    }
}