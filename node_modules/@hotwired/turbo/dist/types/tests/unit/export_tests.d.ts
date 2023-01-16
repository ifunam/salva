import { DOMTestCase } from "../helpers/dom_test_case";
export { PageRenderer, PageSnapshot, FrameRenderer, FrameElement, StreamActions, StreamElement, StreamSourceElement, TurboBeforeCacheEvent, TurboBeforeFetchRequestEvent, TurboBeforeFetchResponseEvent, TurboBeforeFrameRenderEvent, TurboBeforeRenderEvent, TurboBeforeStreamRenderEvent, TurboBeforeVisitEvent, TurboClickEvent, TurboFetchRequestErrorEvent, TurboFrameLoadEvent, TurboFrameMissingEvent, TurboFrameRenderEvent, TurboLoadEvent, TurboRenderEvent, TurboStreamAction, TurboStreamActions, TurboSubmitEndEvent, TurboSubmitStartEvent, TurboVisitEvent, } from "../../index";
export declare class ExportTests extends DOMTestCase {
    "test Turbo interface"(): Promise<void>;
}
