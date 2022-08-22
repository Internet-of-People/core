import { Validation } from "@arkecosystem/crypto";
import { SocketErrors } from "../../enums";

export const validate = (schema, data) => {
    const { error: validationError } = Validation.validator.validate(schema, data);

    if (validationError) {
        const error = new Error(`Data validation error : ${validationError}`);
        error.name = SocketErrors.Validation;

        throw error;
    }
};

// Specific light validation for transaction, to be used in socket workers
// to perform quick validation on transaction objects received in postTransactions
// TODO rework with v3 when refactoring p2p layer
export const validateTransactionLight = (transaction: any): boolean => {
    if (!transaction || typeof transaction !== "object") {
        return false;
    }

    // except for multipayment transactions that are capped to 128 payments currently,
    // a transaction should not have more than 100 properties total
    const maxMainProperties = 50;
    const maxMultiPayments = 128; // hardcoded as will be refactored before increasing max multipayments
    if (Object.keys(transaction).length > maxMainProperties) {
        return false;
    }

    if (transaction.asset && typeof transaction.asset === "object") {
        if (transaction.asset.payments && Array.isArray(transaction.asset.payments)) {
            if (transaction.asset.payments.length > maxMultiPayments) {
                return false;
            }
            for (const p of transaction.asset.payments) {
                if (
                    !p ||
                    typeof p !== "object" ||
                    typeof p.recipientId !== "string" ||
                    typeof p.amount !== "string" ||
                    Object.keys(p).length !== 2
                ) {
                    return false;
                }
            }
            if (Object.keys(transaction.asset).length > 1) {
                return false; // should only contain { payments: [...] }
            }
        }
    }

    const shallowClone = { ...transaction };
    delete shallowClone.asset; // to count main properties now

    return true;
};

