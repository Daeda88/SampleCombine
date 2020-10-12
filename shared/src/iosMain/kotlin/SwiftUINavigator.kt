import com.splendo.kaluga.architecture.navigation.Navigator

interface SwiftUITestNavigator {
    fun showDetails(string: String)
}

class TestNavigator(private val swiftUINavigator: SwiftUITestNavigator) : Navigator<TestNavigationAction<*>> {

    override fun navigate(action: TestNavigationAction<*>) {
        when (action) {
            is TestNavigationAction.Details -> {
                action.bundle?.get(TestDetailsBundleSpecRow.Text)?.let {
                    swiftUINavigator.showDetails(it)
                }
            }
        }
    }
}

interface SwiftUIDetailsNavigator {
    fun close()
}

class DetailsNavigator(private val swiftUINavigator: SwiftUIDetailsNavigator) : Navigator<DetailsNavigationAction<*>> {

    override fun navigate(action: DetailsNavigationAction<*>) {
        when (action) {
            is DetailsNavigationAction.Close -> swiftUINavigator.close()
        }
    }
}