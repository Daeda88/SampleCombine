import com.splendo.kaluga.architecture.observable.Observable
import com.splendo.kaluga.architecture.observable.subjectOf
import com.splendo.kaluga.architecture.viewmodel.BaseViewModel

class TestViewModel : BaseViewModel() {
    val nameFieldText = subjectOf("", coroutineScope)
    private val _nameLabelText = subjectOf("Default value", coroutineScope)
    val nameLabelText: Observable<String> = _nameLabelText

    fun printToLabel() {
        _nameLabelText.post(nameFieldText.current)
    }
}