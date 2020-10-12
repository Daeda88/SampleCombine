import com.splendo.kaluga.alerts.AlertInterface
import com.splendo.kaluga.alerts.buildAlert
import com.splendo.kaluga.architecture.navigation.*
import com.splendo.kaluga.architecture.observable.Observable
import com.splendo.kaluga.architecture.observable.subjectOf
import com.splendo.kaluga.architecture.viewmodel.BaseViewModel
import com.splendo.kaluga.architecture.viewmodel.NavigatingViewModel
import com.splendo.kaluga.hud.HUD
import com.splendo.kaluga.hud.HUDStyle
import com.splendo.kaluga.hud.HudConfig
import com.splendo.kaluga.hud.presentDuring
import com.splendo.kaluga.resources.localized
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

sealed class TestNavigationAction<B : NavigationBundleSpecRow<*>>(bundle: NavigationBundle<B>) : NavigationAction<B>(bundle) {
    data class Details(private val text: String) : TestNavigationAction<TestDetailsBundleSpecRow<*>>(bundle = TestDetailsBundleSpec().toBundle { row ->
        when(row) {
            is TestDetailsBundleSpecRow.Text -> row.convertValue(text)
        }
    })
}

class TestDetailsBundleSpec : NavigationBundleSpec<TestDetailsBundleSpecRow<*>>(setOf(TestDetailsBundleSpecRow.Text))


sealed class TestDetailsBundleSpecRow<T>(associatedType: NavigationBundleSpecType<T>) : NavigationBundleSpecRow<T>(associatedType) {
    object Text : TestDetailsBundleSpecRow<String>(NavigationBundleSpecType.StringType)
}

class TestViewModel(
    val alertBuilder: AlertInterface.Builder,
    val hudBuilder: HUD.Builder,
    navigator: Navigator<TestNavigationAction<*>>
) : NavigatingViewModel<TestNavigationAction<*>>(navigator) {
    val nameFieldText = subjectOf("", coroutineScope)
    private val _nameLabelText = subjectOf("Default value", coroutineScope)
    val nameLabelText: Observable<String> = _nameLabelText

    fun printToLabel() {
        _nameLabelText.post(nameFieldText.current)
    }

    fun showDetails() {
        navigator.navigate(TestNavigationAction.Details(nameFieldText.current))
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