import { Snapshot } from "../snapshot";
declare type ElementDetailMap = {
    [outerHTML: string]: ElementDetails;
};
declare type ElementDetails = {
    type?: ElementType;
    tracked: boolean;
    elements: Element[];
};
declare type ElementType = "script" | "stylesheet";
export declare class HeadSnapshot extends Snapshot<HTMLHeadElement> {
    readonly detailsByOuterHTML: ElementDetailMap;
    get trackedElementSignature(): string;
    getScriptElementsNotInSnapshot(snapshot: HeadSnapshot): HTMLScriptElement[];
    getStylesheetElementsNotInSnapshot(snapshot: HeadSnapshot): HTMLLinkElement[];
    getElementsMatchingTypeNotInSnapshot<T extends Element>(matchedType: ElementType, snapshot: HeadSnapshot): T[];
    get provisionalElements(): Element[];
    getMetaValue(name: string): string | null;
    findMetaElementByName(name: string): Element | undefined;
}
export {};
