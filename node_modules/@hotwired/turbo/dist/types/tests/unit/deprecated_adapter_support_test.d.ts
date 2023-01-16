import { VisitOptions, Visit } from "../../core/drive/visit";
import { FormSubmission } from "../../core/drive/form_submission";
import { Adapter } from "../../core/native/adapter";
import { DOMTestCase } from "../helpers/dom_test_case";
export declare class DeprecatedAdapterSupportTest extends DOMTestCase implements Adapter {
    locations: any[];
    originalAdapter: Adapter;
    setup(): Promise<void>;
    teardown(): Promise<void>;
    "test visit proposal location includes deprecated absoluteURL property"(): Promise<void>;
    "test visit start location includes deprecated absoluteURL property"(): Promise<void>;
    visitProposedToLocation(location: URL, _options?: Partial<VisitOptions>): void;
    visitStarted(visit: Visit): void;
    visitCompleted(_visit: Visit): void;
    visitFailed(_visit: Visit): void;
    visitRequestStarted(_visit: Visit): void;
    visitRequestCompleted(_visit: Visit): void;
    visitRequestFailedWithStatusCode(_visit: Visit, _statusCode: number): void;
    visitRequestFinished(_visit: Visit): void;
    visitRendered(_visit: Visit): void;
    formSubmissionStarted(_formSubmission: FormSubmission): void;
    formSubmissionFinished(_formSubmission: FormSubmission): void;
    pageInvalidated(): void;
}
