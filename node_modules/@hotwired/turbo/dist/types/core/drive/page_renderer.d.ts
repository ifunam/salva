import { Renderer } from "../renderer";
import { PageSnapshot } from "./page_snapshot";
import { ReloadReason } from "../native/browser_adapter";
export declare class PageRenderer extends Renderer<HTMLBodyElement, PageSnapshot> {
    static renderElement(currentElement: HTMLBodyElement, newElement: HTMLBodyElement): void;
    get shouldRender(): boolean;
    get reloadReason(): ReloadReason;
    prepareToRender(): Promise<void>;
    render(): Promise<void>;
    finishRendering(): void;
    get currentHeadSnapshot(): import("./head_snapshot").HeadSnapshot;
    get newHeadSnapshot(): import("./head_snapshot").HeadSnapshot;
    get newElement(): HTMLBodyElement;
    mergeHead(): Promise<void>;
    replaceBody(): void;
    get trackedElementsAreIdentical(): boolean;
    copyNewHeadStylesheetElements(): Promise<void>;
    copyNewHeadScriptElements(): void;
    removeCurrentHeadProvisionalElements(): void;
    copyNewHeadProvisionalElements(): void;
    activateNewBody(): void;
    activateNewBodyScriptElements(): void;
    assignNewBody(): void;
    get newHeadStylesheetElements(): HTMLLinkElement[];
    get newHeadScriptElements(): HTMLScriptElement[];
    get currentHeadProvisionalElements(): Element[];
    get newHeadProvisionalElements(): Element[];
    get newBodyScriptElements(): NodeListOf<HTMLScriptElement>;
}
