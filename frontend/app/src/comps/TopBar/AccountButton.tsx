import { useDemoState } from "@/src/demo-state";
import { css } from "@/styled-system/css";
import { Button, IconAccount } from "@liquity2/uikit";
import { MenuItem } from "./MenuItem";

type ButtonData = {
  label: string;
  onClick: () => void;
  variant?: "normal" | "connected";
};

export function AccountButton() {
  const { account, setDemoState } = useDemoState();
  return (
    account.isConnected
      ? (
        <ButtonConnected
          button={{
            label: "demo.eth",
            onClick: () => {
              setDemoState({
                account: { isConnected: false },
              });
            },
          }}
        />
      )
      : (
        <Button
          mode="primary"
          label="Connect"
          onClick={() => {
            setDemoState({
              account: { isConnected: true },
            });
          }}
        />
      )
  );
}

// import { ConnectButton } from "@rainbow-me/rainbowkit";
// import content from "@/src/content";
// import { match, P } from "ts-pattern";
// export function AccountButton() {
//   return (
//     <ConnectButton.Custom>
//       {({ account, chain, openAccountModal, openChainModal, openConnectModal }) => {
//         const button = match({ account, chain })
//           .returnType<ButtonData>()
//           .with(
//             // wrong network
//             { chain: { unsupported: true } },
//             () => ({
//               label: content.accountButton.wrongNetwork,
//               onClick: openChainModal,
//             }),
//           )
//           .with(
//             // connected
//             { account: P.nonNullable },
//             ({ account }) => ({
//               label: account.displayName,
//               onClick: openAccountModal,
//               variant: "connected",
//             }),
//           )
//           .otherwise(
//             // disconnected / not ready
//             () => ({
//               label: content.accountButton.connectAccount,
//               onClick: openConnectModal,
//             }),
//           );

//         return button.variant === "connected"
//           ? <ButtonConnected button={button} />
//           : (
//             <Button
//               mode="primary"
//               label={button.label}
//               onClick={button.onClick}
//             />
//           );
//       }}
//     </ConnectButton.Custom>
//   );
// }

function ButtonConnected({ button }: { button: ButtonData }) {
  return (
    <button
      onClick={button.onClick}
      className={css({
        display: "flex",
        height: "100%",
        padding: 0,
        _active: {
          translate: "0 1px",
        },
        _focusVisible: {
          borderRadius: 4,
          outline: "2px solid token(colors.focused)",
        },
      })}
    >
      <MenuItem
        icon={<IconAccount />}
        label={button.label}
      />
    </button>
  );
}
