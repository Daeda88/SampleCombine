import com.splendo.kaluga.architecture.navigation.NavigationAction
import com.splendo.kaluga.architecture.navigation.NavigationBundle
import com.splendo.kaluga.architecture.navigation.NavigationBundleSpecRow
import com.splendo.kaluga.architecture.navigation.Navigator
import com.splendo.kaluga.architecture.observable.Observable
import com.splendo.kaluga.architecture.observable.observableOf
import com.splendo.kaluga.architecture.viewmodel.NavigatingViewModel

sealed class DetailsNavigationAction<B : NavigationBundleSpecRow<*>>(bundle: NavigationBundle<B>?) : NavigationAction<B>(bundle) {
    object Close : DetailsNavigationAction<Nothing>(null)
}

class DetailsViewModel(
    text: String,
    navigator: Navigator<DetailsNavigationAction<*>>
) : NavigatingViewModel<DetailsNavigationAction<*>>(navigator) {
    val detailsLabelText: Observable<String> = observableOf(text)

    fun close() {
        navigator.navigate(DetailsNavigationAction.Close)
    }
}